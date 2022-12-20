# queries
My repo for queries


## Notes on DBs

* ANSI/Sparc Architecture - separation between physical, logical and external layers. Independence to guarantee portability.
* Conceptual model - for logical independence (logical layer from conceptual). Abstraction from DBMS.
  * Expressed through ER Schema
* Relational model - for data independence (physical layer from logical)
  * Relation is a typed n-uple (like a table). Elements in a relation are not sorted and all different.
  * Relations are connected through a value-based approach, connections through identifiers and not memory pointers (bidirectionality, portability)
  * A relation has degree N and we have N attributes labeled by attributes headers (columns not sorted, not positional)
  * NULL values are special values out of a domain used to represent undefined, unknown or not available data.
  * Integrity constraint - a predicate that say if a db is correct or not.
    * intra-relational (domain, tuple, key)
    * inter-relational (referential integrity constr)
  * Super-key - set of attributes for which 2 rows are distinct
  * Key - minimal super-key. If you remove an attribute, it's no-more a key. There can be many keys for a relation.
  * Primary-key - key that cannot be null. One for relation.
  * Foreign-key - set of attributes that point to a primary key with a value-based approach or null.
  * Semi-automatic Mapping: ER -> Relational
* Relational Algebra
  * PI - project (vertical decomposition - columns) PI_<attributes>(Relation)
  * SIGMA - select (horizontal decomposition - rows) SIGMA_<expression>(Relation)
  * RHO - rename RHO_<old_attributes> <- <new_attributes>(Relation)
  * SET OPERATORS - minus, union, product, intersect
    * to apply union, minus, intersect two relation must be compatible to union (same degree, attributes and domains)
  * THETA-JOIN - unione di due relation tramite espressione THETA
    * equivale a sigma_theta(AxB)
  * EQUI-JOIN - THETA JOIN con THETA che è uguaglianza tra valori
  * NATURAL-JOIN - EQUI-JOIN con attributi con lo stesso nome. Se l'attributo è PK e FK, la cardinalità dell'unione è la cardinalità di A
  * FULL-OUTER-JOIN - THETA-JOIN con uniti i valori nulli di entrambe le relazioni
  * LEFT/RIGHT OUTER JOIN - THETA JOIN values united with the NULL values of A or B
* SQL - implements relational model, relation algebra + extensions.
  * declarative lang. DDL + DML
  * Table is NOT relation. Table can contain duplicates (multi-set)
  * aggregate function
    * cannot be used together with other columns if not included in GROUP BY
    * cannot be used in where clauses
  * nested queries
    * cannot access alias defined in subquery from parent query
  
