syn keyword sqlStatement declare replace call delimiter describe references
syn match sqlStatement /primary key/
syn match sqlStatement /foreign key/
syn match sqlDelimiterToken /\c^\s*delimiter\>\s*\zs\S\+/
syn match sqlDelimiterToken /^\s*\$\$\s*$/
syn match sqlDelimiterToken /\$\$\s*$/
hi def link sqlDelimiterToken Delimiter

syn match sqlParenAsDelimiter /[();]/
hi def link sqlParenAsDelimiter Delimiter

syn keyword sqlStatement signal sqlstate

syn keyword sqlType
      \ tinyint smallint mediumint int integer bigint
      \ decimal dec numeric fixed float double real bit
      \ bool boolean serial

syn keyword sqlType
      \ date datetime timestamp time year

syn keyword sqlType
      \ char varchar binary varbinary
      \ tinytext text mediumtext longtext
      \ tinyblob blob mediumblob longblob
      \ enum set

syn keyword sqlType
      \ json

syn keyword sqlType
      \ geometry point linestring polygon
      \ multipoint multilinestring multipolygon geometrycollection
