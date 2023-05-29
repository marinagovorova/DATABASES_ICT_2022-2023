from bottle import redirect, request, route, run, template
from DBase import Session, Event, Calendar
from datetime import datetime, timedelta, date
from calendar import monthrange

@route("/calendar")
def calendar():
    s = Session()

    today = date.today()

    month = int(request.query.get("month", today.month))
    year = int(request.query.get("year", today.year))

    first_day = date(year, month, 1)
    _, num_days = monthrange(year, month)
    last_day = date(year, month, num_days)

    calendar = []
    week = [0] * first_day.weekday()
    for day in range(1, num_days + 1):
        week.append(day)
        if len(week) == 7:
            calendar.append(week)
            week = []
    if week:
        calendar.append(week)

    events = s.query(Event).filter(Event.date.between(first_day, last_day)).all()

    return template("C:/Users/HP/Calendar/template/Template.html", calendar=calendar, month=month, year=year, events=events)

@route("/create_event")
def create_event():
    return template("C:/Users/HP/Calendar/template/CreateEvent.html")

@route("/save_event", method="POST")
def save_event():
    s = Session()

    title = request.forms.get("title")
    date_str = request.forms.get("date")
    begin_time = request.forms.get("begin_time")
    end_time = request.forms.get("end_time")
    description = request.forms.get("description")

    date = datetime.strptime(date_str, "%Y-%m-%d").date()

    errors = []
    if not title:
        errors.append("Введи название, чел")
    if not date_str:
        errors.append("Введи дату, чел")
    if not begin_time:
        errors.append("Когда начинаем?")
    if not end_time:
        errors.append("Когда заканчиваем?")
    if begin_time >= end_time:
        errors.append("Время должно быть корректным.")
    if date.year > 2024 or date.year < 2000:
        errors.append("Мы живем в настоящем.")

    if errors:
        return template("C:/Users/HP/Calendar/template/CreateEvent.html", errors=errors)

    new_event = Event(title=title, date=date, begin_time=begin_time, end_time=end_time, description=description)
    s.add(new_event)
    s.commit()

    return redirect("/calendar?month={}&year={}".format(date.month, date.year))

@route("/update_event/<event_id>")
def update_event(event_id):
    s = Session()
    event = s.query(Event).get(event_id)
    return template("C:/Users/HP/Calendar/template/UpdateEvent.html", event=event)

@route("/save_event/<event_id>", method="POST")
def save_updated_event(event_id):
    s = Session()

    title = request.forms.get("title")
    date_str = request.forms.get("date")
    begin_time = request.forms.get("begin_time")
    end_time = request.forms.get("end_time")
    description = request.forms.get("description")

    date = datetime.strptime(date_str, "%Y-%m-%d").date()

    errors = []
    if not title:
        errors.append("Введи название, чел")
    if not date_str:
        errors.append("Введи дату, чел")
    if not begin_time:
        errors.append("Когда начинаем?")
    if not end_time:
        errors.append("Когда заканчиваем?")
    if begin_time >= end_time:
        errors.append("Время должно быть корректным.")
    if date.year > 2024 or date.year < 2000:
        errors.append("Мы живем в настоящем.")

    if errors:
        return template("C:/Users/HP/Calendar/template/UpdateEvent.html", event=event, errors=errors)

    event = s.query(Event).filter_by(id = event_id).update(dict(title = title, date = date, begin_time=begin_time,
                                                           end_time = end_time, description = description))

    s.commit()

    return redirect("/calendar?month={}&year={}".format(date.month, date.year))

@route("/delete_event/<event_id>")
def delete_event(event_id):
    s = Session()
    event = s.get(Event, event_id)
    s.delete(event)
    s.commit()
    return redirect("/calendar?month={}&year={}".format(event.date.month, event.date.year))

if __name__ == "__main__":
    run(host="127.0.0.1", port=8080)
