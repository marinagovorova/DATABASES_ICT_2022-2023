from bottle import redirect, request, route, run, template, error
from DBase import Session, Event, Month
from datetime import datetime, date, timedelta
from calendar import monthrange


@route("/calendar")
def calendar():
    s = Session()
    today = date.today()

    month = int(request.query.get("month", today.month))
    year = int(request.query.get("year", today.year))

    date1 = datetime.now()
    date2 = datetime(day=1, month=1, year=datetime.now().year)
    timedelta = (date1 - date2).days
    currentmonth = 1 + timedelta // 30
    currentday = timedelta % 30

    first_day = date(year, month, 1)
    _, num_days = monthrange(year, month)
    last_day = date(year, month, num_days)
    calendar = []
    week = []
    for day in range(1, 31):
        week.append(day)
        if len(week) == 10:
            calendar.append(week)
            week = []
    if week:
        calendar.append(week)
    events = s.query(Event).filter(Event.date.between(first_day, last_day)).all()
    currentyear = datetime.now().year
    month_info = s.query(Month).filter(Month.id == month).all()
    return template("/Users/lizaarnautova/BD site/site/Hehehe/Template.html", calendar=calendar, month=month, year=year,
                    events=events, month_info=month_info, currentday=currentday, currentmonth=currentmonth,
                    currentyear=currentyear)


@route("/create_event")
def create_event():
    return template("/Users/lizaarnautova/BD site/site/Hehehe/CreateEvent2.html")


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
    if not end_time:
        end_time = datetime.strptime(begin_time, '%H:%M') + timedelta(2)
    if not title:
        errors.append("No title")
    if not date_str:
        errors.append("No date")
    if not begin_time:
        errors.append("No time")
    if date.year > 2024 or date.year < 2000:
        errors.append("Incorrect year")
    if errors:
        return template("/Users/lizaarnautova/BD site/site/Hehehe/CreateEvent2.html", errors=errors)
    new_event = Event(title=title, date=date, begin_time=begin_time, end_time=end_time, description=description)
    s.add(new_event)
    s.commit()
    return redirect("/calendar?month={}&year={}".format(date.month, date.year))


@route("/update_event/<event_id>")
def update_event(event_id):
    s = Session()
    event = s.query(Event).get(event_id)
    return template("/Users/lizaarnautova/BD site/site/Hehehe/UpdateEvent2.html", event=event)


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
    if not end_time:
        end_time = datetime.strptime(begin_time, '%H:%M') + timedelta(2)

    if not title:
        errors.append("No title")
    if not date_str:
        errors.append("No date")
    if not begin_time:
        errors.append("No time")
    if date.year > 2024 or date.year < 2000:
        errors.append("Incorrect year")
    event = s.query(Event).filter_by(id=event_id).update(dict(title=title, date=date, begin_time=begin_time,
                                                              end_time=end_time, description=description))
    if errors:
        return template("/Users/lizaarnautova/BD site/site/Hehehe/UpdateEvent2.html", event=event, errors=errors)

    s.commit()
    return redirect("/calendar?month={}&year={}".format(date.month, date.year))


@route("/delete_event/<event_id>")
def delete_event(event_id):
    s = Session()
    event = s.get(Event, event_id)
    s.delete(event)
    s.commit()
    return redirect("/calendar?month={}&year={}".format(event.date.month, event.date.year))

#
# @error(500)
# def mistake500(code):
#     return calendar()
#
#
@error(404)
def mistake404(code):
    return calendar()


if __name__ == "__main__":
    run(host="localhost", port=8080, reloader=True)
