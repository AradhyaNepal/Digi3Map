# Generated by Django 4.0.2 on 2022-04-07 07:07

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auth_pg', '0003_customuser_progress_percentage'),
    ]

    operations = [
        migrations.AlterField(
            model_name='customuser',
            name='progress_percentage',
            field=models.FloatField(default=1),
        ),
    ]
