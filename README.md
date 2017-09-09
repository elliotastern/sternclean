
`sternclean` seeks to simplify cleaning dataframes as much as possible.

Multiple cleaning steps can be done in just one function.

For example, you can change column types, impute one set of columns' NAs with a set value, impute another set of columns' NAs with a group mean, and impute another set of columns' infinite values with another set value in a few lines of clean code

Here is the order of operations under the hood:

-   Change the types
-   Remove columns
-   Impute NAs
-   Impute infinites

This allows multiple cleaning processes to happen in this one function

Simple Examples
---------------

We will start out with over simple one step cleaning steps. Later we will take on more complex situations

### Rickle and Mortan Dataset

<table style="width:83%;">
<colgroup>
<col width="22%" />
<col width="25%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

Class Change Parameters
-----------------------

``` r
class(rickle_and_mortan$people)
#> [1] "factor"

sternclean("rickle_and_mortan",
           class_to_strng = "people")

class(rickle_and_mortan$people)
#> [1] "character"
```

``` r
class(rickle_and_mortan$intelligence)
#> [1] "character"

sternclean("rickle_and_mortan",
           class_to_numer = "intelligence")

class(rickle_and_mortan$intelligence)
#> [1] "numeric"
```

Column/Row Removal Parameters
-----------------------------

``` r
sternclean("rickle_and_mortan",
           remove_columns = "intelligence")
```

<table style="width:62%;">
<colgroup>
<col width="22%" />
<col width="25%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">Rickle</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           remove_na_rows =  "evil_rank")
```

<table style="width:74%;">
<colgroup>
<col width="12%" />
<col width="25%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           removeby_regex = "pe")
```

<table style="width:36%;">
<colgroup>
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Inf</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           remove_all_nas = TRUE)
```

<table style="width:74%;">
<colgroup>
<col width="12%" />
<col width="25%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           remove_non_num = TRUE)
```

<table style="width:36%;">
<colgroup>
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Inf</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           remove_all_exc = c("people", "evil_rank"))
```

<table style="width:38%;">
<colgroup>
<col width="22%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

Impute Parameters
-----------------

``` r
sternclean("rickle_and_mortan",
           impute_na2mean = "evil_rank")
```

<table style="width:83%;">
<colgroup>
<col width="22%" />
<col width="25%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">3.25</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           impute_na_cols = "evil_rank",
           impute_na_with = 1738)
```

<table style="width:83%;">
<colgroup>
<col width="22%" />
<col width="25%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">1738</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           impute_grpmean = "evil_rank",
           impute_grpwith = "original_person")
```

<table style="width:83%;">
<colgroup>
<col width="25%" />
<col width="22%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">original_person</th>
<th align="center">people</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Rickle</td>
<td align="center">Pickle Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           impute_inf_col = "intelligence",
           impute_inf_wit = 1738)
```

<table style="width:83%;">
<colgroup>
<col width="22%" />
<col width="25%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">1738</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">Rickle</td>
<td align="center">1738</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

``` r
sternclean("rickle_and_mortan",
           impute_cust_cl = "evil_rank",
           impute_cust_fn = quantile,
           probs = .25,
           na.rm = TRUE
           )
```

<table style="width:83%;">
<colgroup>
<col width="22%" />
<col width="25%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">original_person</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">Rickle</td>
<td align="center">Inf</td>
<td align="center">2.375</td>
</tr>
</tbody>
</table>

More Complex Example
--------------------

Here we:

-   change the people column's class to string
-   change the intelligence column's class to numeric
-   remove the original\_person column
-   impute the NAs in the evil rank with the column's mean
-   impute the infite values in the intelligence column to 1738

``` r
sternclean("rickle_and_mortan",
           class_to_strng = "people",
           class_to_numer = "intelligence",
           remove_columns = "original_person",
           impute_na2mean = "evil_rank",
           impute_inf_col = "intelligence",
           impute_inf_wit = 1738
           )
```

<table style="width:58%;">
<colgroup>
<col width="22%" />
<col width="20%" />
<col width="15%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">people</th>
<th align="center">intelligence</th>
<th align="center">evil_rank</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">Rickle</td>
<td align="center">1738</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">Mortan</td>
<td align="center">9</td>
<td align="center">2.75</td>
</tr>
<tr class="odd">
<td align="center">Jerry</td>
<td align="center">0.1</td>
<td align="center">2</td>
</tr>
<tr class="even">
<td align="center">Pickle Rickle</td>
<td align="center">1738</td>
<td align="center">3.25</td>
</tr>
</tbody>
</table>

> "For more, checkout my " ([Github](https://github.com/basketballbeane))
