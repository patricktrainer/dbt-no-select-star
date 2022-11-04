# dbt-no-select-star
![Ah! Ah! Ah!](etc/ah-ah-ah.gif)

This [dbt](https://github.com/dbt-labs/dbt) package contains a macro that will throw an error if you attempt to use `select *` in your model. This macro effectively forces you to be explicit about the columns you want to select.

## Installation
Adding this package to your project will enable the macro. To install, add the following to your `packages.yml` file:

```yml
packages:
  - git: "https://github.com/patricktrainer/dbt-no-select-star.git"
    revision: 0.1.0
```

## Usage
To use the macro, simply add the following at the end of your model:

```sql
{{ no_select_star() }}
```

For example:

```sql
select 
  my_column,
  my_other_column,
  {{ no_select_star() }}
from {{ ref(my_table) }}
```

This will throw an error if you attempt to use `select *` in your model.

The error message will look like this:

```bash
'DONT SELECT * FROM THIS TABLE!!!1'
```

To avoid the error, be explicit about the columns you want to select:

```sql
select 
  my_column,
  my_other_column
from {{ ref(my_table) }}
```

## How does this work?
This works by leveraging _computed columns_. Computed columns are a feature that allow you to create a column that is the result of a SQL expression. If you inspect [the macro](macros/no_select_star.sql), you'll notice that it creates a `string` typed column. This column is then cast as a `char()` type with a length of 1 byte. Obviously, the string "DONT SELECT * FROM THIS TABLE!!!1" is longer than 1 byte, so the cast will fail. This will cause the query to fail, and the error message will be displayed.
