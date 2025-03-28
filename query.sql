SELECT
  TOP(10) t.a
FROM
  my_table t;

SELECT
  TOP(20) a.*
FROM
  (
    SELECT
      TOP(20) a
    FROM
      users4sn u4sn
      JOIN users u ON u.p_uid = u4sn.CHNGINGUSER
    WHERE
      u4sn.CHANGINGUSER <> JSON_VALUE(PAYLOADBEFORE, '$.attributes.uid.value[0]')
      AND JSON_VALUE(PAYLOADBEFORE, '$.attributes.type.value[0]') LIKE '%CustomerType%'
      AND u4sn.CHANGINGUSER != 'anonymous'
      AND u4sn.CHANGINGUSER != 'admin'
    UNION
    ALL
    SELECT
      TOP(100) u.p_name,
      a.*
    FROM
      addresses23sn a
      JOIN users u ON u.p_uid = a.CHANGINGUSER
    WHERE
      (
        (
          JSON_VALUE(a.PAYLOADBEFORE, '$.attributes.owner.value[0]') IS NOT NULL
          AND u.PK <> JSON_VALUE(a.PAYLOADBEFORE, '$.attributes.owner.value[0]')
        )
        OR (
          JSON_VALUE(a.PAYLOADAFTER, '$.attributes.owner.value[0]') IS NOT NULL
          AND u.PK <> JSON_VALUE(a.PAYLOADAFTER, '$.attributes.owner.value[0]')
        )
      )
      AND (
        (
          JSON_VALUE(a.PAYLOADBEFORE, '$.attributes.email.value[0]') IS NOT NULL
          AND a.CHANGINGUSER <> JSON_VALUE(a.PAYLOADBEFORE, '$.attributes.email.value[0]')
        )
        OR (
          JSON_VALUE(a.PAYLOADAFTER, '$.attributes.email.value[0]') IS NOT NULL
          AND a.CHANGINGUSER <> JSON_VALUE(a.PAYLOADAFTER, '$.attributes.email.value[0]')
        )
      )
      AND a.CHANGINGUSER NOT IN ('anonymous', 'admin')
  ) AS CombinedResults
ORDER BY
  timestamp DESC;

SELECT
  { p :PK }
FROM
  { Product AS p }
WHERE
  { p :code } LIKE '%myProduct'
  OR { p :name } LIKE '%myProduct'
ORDER BY
  { p :code } ASC;
