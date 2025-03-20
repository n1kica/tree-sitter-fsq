SELECT
  { p :PK }
FROM
  { Product AS p }
WHERE
  { p :code } LIKE '%myProduct'
  OR { p :name } LIKE '%myProduct'
ORDER BY
  { p :code } ASC
