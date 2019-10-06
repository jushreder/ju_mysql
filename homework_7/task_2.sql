/*
2.Выведите список товаров products и разделов catalogs,
 который соответствует товару.
*/
use shop;

select id, name, (select name from catalogs where id = catalog_id) as 'catalog'
from products; 

