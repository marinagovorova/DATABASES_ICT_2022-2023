from django.urls import path

from . import views

app_name = 'pets'
urlpatterns = [
    path('', views.index, name='index'),
    path('species/', views.list_species, name='species'),
    path('add_species/', views.add_species, name='add_species'),
    path('species/update_species/<int:num>', views.update_species, name='update_species'),
    path('species/delete_species/<int:num>', views.delete_species, name='delete_species'),
    path('pets/', views.list_pets, name='pets'),
    path('add_pets/', views.add_pets, name='add_pets'),
    path('pets/update_pets/<int:num>', views.update_pets, name='update_pets'),
    path('pets/delete_pets/<int:num>', views.delete_pets, name='delete_pets'),

]
