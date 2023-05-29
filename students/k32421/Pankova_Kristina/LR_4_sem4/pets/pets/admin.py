from django.contrib import admin
from .models import Pet


#class PetAdmin(admin.ModelAdmin):
 #   list_display = ('name', 'age', 'species', 'rating', 'comment')

from .models import Species
from .models import Pet


admin.site.register(Pet)

class PetInline(admin.TabularInline):
    model = Pet
    extra = 3


class SpeciesAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['name']}),
    ]
    inlines = [PetInline]


admin.site.register(Species, SpeciesAdmin)

#admin.site.register(Pet, PetAdmin)