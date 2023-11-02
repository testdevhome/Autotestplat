from django.shortcuts import render

def login_view(request):
    if request.method == 'GET':
        return render(request, 'login.html')