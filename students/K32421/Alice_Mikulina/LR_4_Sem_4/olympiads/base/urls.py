from django.urls import path
from . import views


urlpatterns = [
    path('olympiads/all/', views.list_olympiads, name='Olympiads'),
    path('levels/all/', views.list_levels, name='Levels'),
    path('create/olympiad', views.create_olympiad, name='create_olympiad'),
    path('create/level', views.create_level, name='create_level'),
    path('delete/olympiad/<int:num>', views.delete_olympiad, name='delete_olympiad'),
    path('delete/level/<int:num>', views.delete_level, name='delete_level'),
    path('update/olympiad/<int:num>', views.update_olympiad, name='update_olympiad'),
    path('update/level/<int:num>', views.update_level, name='update_level'),
]