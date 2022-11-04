{% macro no_select_star() %}
'DONT SELECT * FROM THIS TABLE!!!1'::CHAR(1) as no_select_star
{% endmacro %}
