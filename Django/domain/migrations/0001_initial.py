# Generated by Django 4.0.2 on 2022-03-14 04:53

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Domain',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('photo_url', models.CharField(max_length=100)),
                ('description', models.CharField(max_length=250)),
                ('priority', models.CharField(max_length=10)),
            ],
        ),
    ]
