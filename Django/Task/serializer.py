from rest_framework import serializers

from Task.models import DietTransaction, FitnessTransaction, ImplementTransaction, StudyTransaction

class FitnessTransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model=FitnessTransaction
        fields='__all__'


class DietTransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model=DietTransaction
        fields='__all__'
        
class LearningTransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model=StudyTransaction
        fields='__all__'

class ImplementingTransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model=ImplementTransaction
        fields='__all__'