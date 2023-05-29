from django.db import models


class Species(models.Model):
    name = models.CharField(max_length=255)
    rating = models.IntegerField()

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['id']


class Pet(models.Model):
    name = models.CharField(max_length=255)
    age = models.IntegerField()
    species_id = models.ForeignKey(Species, on_delete=models.CASCADE)
    rating = models.IntegerField()
    comment = models.CharField(max_length=255)

    def __str__(self):
        return self.name

    class Meta:
        ordering = ['id']