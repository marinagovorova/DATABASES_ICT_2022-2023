from django.shortcuts import get_object_or_404, render
from base.models import Olympiad, Level
from base.forms import OlympiadForm, LevelForm




def list_olympiads(request):
    '''
    Shows all the olympiads
    '''

    all_olympiads = Olympiad.objects.all()

    context = {
        'olympiads': all_olympiads,
    }

    return render(request, 'olympiads.html', context=context)




def list_levels(request):
    '''
    Shows all the levels of olympiads
    '''
    
    levels = Level.objects.all()

    context = {
        'levels': levels
    }

    return render(request, 'levels.html', context=context)




def create_level(request):
    '''
    Allows creating exercise types via /create/level/
    '''

    if request.method == 'POST':

        form =LevelForm(request.POST)

        if form.is_valid():

            form.save()

            form = LevelForm()

            context = {
                    'form': form
                }

            return render(request, 'mission_successful.html', context=context)
        return render(request, 'create_level.html', context=context)

    else:
        form = LevelForm()

        context = {
            'form': form
            }

        return render(request, 'create_level.html', context=context)
    



def create_olympiad(request):
    '''
    Allows creating exercise types via /create/olympiad/
    '''

    if request.method == 'POST':

        form =OlympiadForm(request.POST)

        if form.is_valid():

            form.save()

            form = OlympiadForm()

            context = {
                    'form': form
                }

            return render(request, 'mission_successful.html', context=context)
        return render(request, 'create_olympiad.html', context=context)

    else:
        form = OlympiadForm()

        context = {
            'form': form
            }

        return render(request, 'create_olympiad.html', context=context)
    



def delete_level(request, num):
    
    Level.objects.filter(id=num).delete()

    levels = Level.objects.all()

    context = {
        'levels': levels
    }

    return render(request, 'levels.html', context=context)




def delete_olympiad(request, num):
    
    Olympiad.objects.filter(id=num).delete()

    all_olympiads = Olympiad.objects.all()

    context = {
        'olympiads': all_olympiads,
    }

    return render(request, 'olympiads.html', context=context)




def update_level(request, num):
    '''
    Allows updating exercise types via /update/level/
    '''
    level = get_object_or_404(Level, id=num)

    if request.method == 'POST':

        form = LevelForm(request.POST, instance=level)

        if form.is_valid():

            form.save()

            context = {
                    'form': form
                }
            
            return render(request, 'mission_successful.html', context=context)
        return render(request, 'update_level.html', context=context)
    
    else:
        form = LevelForm(instance=level)

        context = {
            'form': form
            }
        
        return render(request, 'update_level.html', context=context)
    



def update_olympiad(request, num):
    '''
    Allows updating exercise types via /update/olympiad/
    '''
    olympiad = get_object_or_404(Olympiad, id=num)

    if request.method == 'POST':

        form = OlympiadForm(request.POST, instance=olympiad)

        if form.is_valid():

            form.save()

            context = {
                    'form': form
                }
            
            return render(request, 'mission_successful.html', context=context)
        return render(request, 'update_olympiad.html', context=context)
    
    else:
        form = OlympiadForm(instance=olympiad)

        context = {
            'form': form
            }
        
        return render(request, 'update_olympiad.html', context=context)