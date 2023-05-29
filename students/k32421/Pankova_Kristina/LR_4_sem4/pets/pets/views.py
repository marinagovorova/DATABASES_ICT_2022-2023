from django.http import HttpResponse
from django.shortcuts import get_object_or_404, render

from .models import Pet, Species
from .forms import PetForm, SpeciesForm


def index(request):
    latest_pet_list = Pet.objects.order_by('-id')[:5]
    context = {
        'latest_pet_list': latest_pet_list,
    }
    return render(request, 'pets/index.html', context)

def add_species(request):
    if request.method == 'POST':

        form = SpeciesForm(request.POST)

        if form.is_valid():

            form.save()

            form = SpeciesForm()

            context = {
                    'form': form
                }

          #  return render(request, 'mission_successful.html', context=context)
        return render(request, 'add_species.html', context=context)

    else:
        form = SpeciesForm()

        context = {
            'form': form
            }

        return render(request, 'add_species.html', context=context)


def list_species(request):
    species = Species.objects.all()

    context = {
        'species': species
    }

    return render(request, 'species.html', context=context)


def update_species(request, num):
    '''
    Allows updating exercise types via /update/level/
    '''
    level = get_object_or_404(Species, id=num)

    if request.method == 'POST':

        form = SpeciesForm(request.POST, instance=level)

        if form.is_valid():
            form.save()

            context = {
                'form': form
            }

            return render(request, 'base.html', context=context)
        return render(request, 'update_species.html', context=context)

    else:
        form = SpeciesForm(instance=level)

        context = {
            'form': form
        }

        return render(request, 'update_species.html', context=context)


def delete_species(request, num):
    Species.objects.filter(id=num).delete()

    species = Species.objects.all()

    context = {
        'species': species
    }

    return render(request, 'species.html', context=context)

def add_pets(request):
    if request.method == 'POST':

        form = PetForm(request.POST)

        if form.is_valid():

            form.save()

            form = PetForm()

            context = {
                    'form': form
                }

          #  return render(request, 'mission_successful.html', context=context)
        return render(request, 'add_pets.html', context=context)

    else:
        form = PetForm()

        context = {
            'form': form
            }

        return render(request, 'add_pets.html', context=context)


def list_pets(request):
    pets = Pet.objects.all()

    context = {
        'pets': pets
    }

    return render(request, 'pets.html', context=context)

def update_pets(request, num):
    '''
    Allows updating exercise types via /update/level/
    '''
    level = get_object_or_404(Pet, id=num)

    if request.method == 'POST':

        form = PetForm(request.POST, instance=level)

        if form.is_valid():
            form.save()

            context = {
                'form': form
            }

            return render(request, 'base.html', context=context)
        return render(request, 'update_pets.html', context=context)

    else:
        form = PetForm(instance=level)

        context = {
            'form': form
        }

        return render(request, 'update_pets.html', context=context)


def delete_pets(request, num):
    Pet.objects.filter(id=num).delete()

    pets = Pet.objects.all()

    context = {
        'pets': pets
    }

    return render(request, 'pets.html', context=context)

