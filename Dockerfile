FROM fernandotalonso/php7-apache-oci8

# alterar a chave do newrelic, caso necessário
#ARG CHAVE_NEWRELIC=<this is where you put your newrelic key>
#ARG NOME_APLICACAO_PHP="<Name of application to show in Newrelic dashboard>"

# adiciona o arquivo com os bancos oracle utilizados dentro da b2w
ADD docker/oracle/tnsnames.ora /usr/local/instantclient/network/admin/
RUN ln -s /usr/local/instantclient/network/admin/tnsnames.ora /usr/local/instantclient/tnsnames.ora

# configurações personalizadas do php
ADD docker/php/php.ini /usr/local/etc/php/php.ini

# configurações de performance de processos do apache
ADD docker/apache/mpm_prefork.conf /etc/apache2/mods-available/mpm_prefork.conf

# esse arquivo serve pra corrigir um problema de resolução de dns dentro das máquinas de desenvolvimento
ADD docker/hosts-prd /tmp/
RUN cat /tmp/hosts-prd >> /etc/hosts
#RUN cat /tmp/resolv.conf >> /etc/resolv.conf
RUN chown www-data: /etc/hosts

## instala a extensão do newrelic dentro da imagem
ADD docker/newrelic/newrelic-php5-common_8.1.0.209_all.deb /tmp/
ADD docker/newrelic/newrelic-daemon_8.1.0.209_amd64.deb /tmp/
RUN dpkg -i /tmp/newrelic-php5-common_8.1.0.209_all.deb
RUN dpkg -i /tmp/newrelic-daemon_8.1.0.209_amd64.deb
ADD docker/newrelic/newrelic-20170718.so /usr/lib/newrelic-php5/agent/x64/
RUN ln -s /usr/lib/newrelic-php5/agent/x64/newrelic-20170718.so /usr/local/lib/php/extensions/no-debug-non-zts-20170718/newrelic.so
ADD docker/php/newrelic.ini /usr/local/etc/php/conf.d/
# o comando abaixo configura a licença do newrelic dentro do arquivo de configuração
#RUN sed -i "s|REPLACE_WITH_REAL_KEY|$CHAVE_NEWRELIC|g" /usr/local/etc/php/conf.d/newrelic.ini
#RUN sed -i "s|NOME_APLICACAO_PHP|$NOME_APLICACAO_PHP|g" /usr/local/etc/php/conf.d/newrelic.ini

VOLUME ["/opt/logs"]
