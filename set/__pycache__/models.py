from django.db import models

# Create your models here.

class Set(models.Model):
    setname = models.CharField('产品名称',max_length=64)  # 设置名称
    setvalue = models.CharField('产品描述',max_length=200)    # 设置值
    class Meta:
        verbose_name = '系统设置'
        verbose_name_plural = '系统设置'
    def __str__(self):
        return self.setname
