from django.db import models

from django.dispatch import receiver
from django.urls import reverse
from django_rest_passwordreset.signals import reset_password_token_created
from django.core.mail import send_mail  


@receiver(reset_password_token_created)
def password_reset_token_created(sender, instance, reset_password_token, *args, **kwargs):

    email_plaintext_message = "token={}".format(reset_password_token.key)

    send_mail(
        # title:
        "Password Reset for {title}".format(title="Digi3Map"),
        # message:
        email_plaintext_message,
        # from:
        "aradhya.1221@gmail.com",
        # to:
        [reset_password_token.user.email],
    )