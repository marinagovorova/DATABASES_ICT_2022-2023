from sqlalchemy import create_engine
from sqlalchemy import Column, Integer, String, Time, Date, ForeignKey
from sqlalchemy.orm import sessionmaker, declarative_base
from datetime import timedelta, time, date, datetime
from sqlalchemy import CheckConstraint

db_string = "postgresql://postgres:12345678@127.0.0.1:5432/clndr"

Base = declarative_base()
engine = create_engine(db_string)
Session = sessionmaker(bind=engine)


class Calendar(Base):
    __tablename__ = "calendar"
    id = Column(Integer, primary_key=True, autoincrement=True)
    date = Column(Date, nullable=False, unique=True)
    day_of_week = Column(Integer, nullable=False)


class Event(Base):
    __tablename__ = "event"
    id = Column(Integer, primary_key=True, autoincrement=True)
    title = Column(String(40), nullable=False)
    date = Column(Date, ForeignKey("calendar.date"), nullable=False, default=date.today)
    begin_time = Column(Time, nullable=False, default=datetime.now().strftime("%H:%M:%S"))
    end_time = Column(Time, default=(begin_time + '01:00:00'))
    description = Column(String(500))
    CheckConstraint("end_time > begin_time", name='check_time')


class Month(Base):
    __tablename__ = "month"
    id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(9), nullable=False)
    common_name = Column(String(25), nullable=False)
    annual_holiday = Column(String(21))


Base.metadata.create_all(bind=engine)
s = Session()
if s.query(Calendar).count() == 0:
    start_date = date(2000, 1, 1)
    end_date = date(2025, 12, 31)
    delta = timedelta(days=1)
    while start_date <= end_date:
        date_ = start_date.strftime("%Y-%m-%d")
        new_date = Calendar(date=date_, day_of_week=datetime.isoweekday(start_date))
        s.add(new_date)
        start_date += delta
    s.commit()
