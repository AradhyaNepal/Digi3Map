# Generated by Django 4.0.2 on 2022-03-20 13:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('domain', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='domain',
            name='percentage',
        ),
        migrations.AddField(
            model_name='domain',
            name='points',
            field=models.IntegerField(default=0),
        ),
    ]
