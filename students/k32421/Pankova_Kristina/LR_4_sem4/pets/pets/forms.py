from django import forms
from .models import Pet, Species

class SpeciesForm(forms.ModelForm):

    class Meta:
        model = Species
        fields = [
            'name',
            'rating'
        ]

        labels = {
            'name': 'Add a new species',
            'rating': 'Rate your species'
        }


class PetForm(forms.ModelForm):

    class Meta:
        model = Pet
        fields = [
            'name',
            'rating',
            'age',
            'comment',
            'species_id',
        ]

        labels = {
            'name': 'Add a name for the pet',
            'rating': 'Add the rating for the pet ',
            'age': 'Enter the age of your pet',
            'comment': 'Any comments?',
            'species_id': 'Choose their species',
        }