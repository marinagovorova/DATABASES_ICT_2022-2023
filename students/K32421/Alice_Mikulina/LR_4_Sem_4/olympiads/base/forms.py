from django import forms
from .models import Level, Olympiad



class LevelForm(forms.ModelForm):

    class Meta:
        model = Level
        fields = [
            'level'
        ]

        labels = {
            'level': 'Add a new olympiad level'
        }


class OlympiadForm(forms.ModelForm):

    class Meta:
        model = Olympiad
        fields = [
            'name',
            'level'
        ]

        labels = {
            'name': 'Add a name for the olympiad',
            'level': 'Add the olympiad level'
        }