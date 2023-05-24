from django.db import models


class Level(models.Model):
    level = models.CharField(max_length=256, unique=True)

    def __str__(self) -> str:
        return self.level

    class Meta:
        ordering = ['id']


class Olympiad(models.Model):
    name = models.CharField(max_length=256)
    level = models.ForeignKey(Level, on_delete=models.PROTECT, related_name='olympiads')

    def __str__(self) -> str:
        return f'{self.name}'
    
    class Meta:
        ordering = ['id']