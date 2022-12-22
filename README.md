# queries
My repo for queries


## Notes on DBs

* DB represents a UoD (universe of discourse) or mini-world. Permanent collection of data indicating known facts.
  * They are (must be): big, shared, secure, durable, efficient
  * Instead a file system: NO durability, redundancy/inconsistency, NO isolation/atomicity
* ANSI/Sparc Architecture - separation between physical, logical and external layers.
  * Consequence 1: Logical Independence. If I change how the app works, the db shouldn't change.
  * Consequence 2: Physical independence. If I change physical structure or move servers (portability) the logical schema doesn't change.
* Requirement analysis: NLS -> FS -> Data Dictionary / Glossary
  * The output of the requirement analysis is the conceptual schema (WHAT to be done) - Completely DBMS independent
  * Data model (schema) - set of symbolic structures to represent the UoD
  * a schema is descriptive (intensional level). An instance is enumerative (extensional level)
  * a schema should be: complete, correct, minimal, readable
* Conceptual model - for logical independence (logical layer from conceptual). Abstraction from DBMS.
  * Expressed through conceptual/ER Schema
* ER schema
  * entity - classification abstraction
  * relation - association abstraction (n-ary, recursive..)
  * attribute - aggregation abstraction (domain-specific, NULL values, also on relations)
  * integrity constraint
    * cardinality constr. on relationships (0/1 lower bound 1/N upper bound)
    * cardinality constr on attributes (0,1 or default 1,1 or 1,N or 0,N)
    * identification constr (choose identifier, also external)
    * external constr
  * data dictionary documents ER schema
* redundancy checks - derived attributes ...
* DB load calculations
  * identify supported operations (IRUD, online/batch)
  * identify data volume (AVG no. of instances in an entity, in a relation i calculate from cardianlity)
  * I plot frequency table to describe kind of op and frequency
  * I plot access/volume table with avg access: access x freq x weight
    * person - entity - 1 access - type Write - avg access: 1x500x2=1000
    * live - relationship - 1 access - type Write - avg access: 1x500x2=1000
    * city - entity - 1 access - type Read - avg access: 1x500x1=500  -- R/U
    * city - entity - 1 access - type Write - avg access: 1x500x2=1000  -- R/U
* Partitioning/merging - for performance reasons
  * vertical - split entity rows in more entities
  * horiz - split entity columns in more entities (copy paste of identifiers)
  * merging - merge diff entities destroying de-duplication of schema. I could have AC AD AE AF BC BD BE BF instead of A B C D E F
* Relational model - for data independence (physical/internal layer from logical)
  * Relational schema - HOW things are done - dependent to DBMS class but independent to physical layer. Not always minimal
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
    * map every entity E to Re
    * Re has got all the attr of E plus all the ext identifiers
    * Underline identifiers for Re
    * map every rel Q to Rq
      * if many to many, a new relation
      * if 1 to many, merge with the Re with lowest cardinality side relation
      * if 1 to 1, merge with the non-optional participation if possible, or choose a direction
    * Rq has the attribute of Q
    * identifiers of Rq are all the Re PKs
    * link FKs to PKs. FKs are not PKs!
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
* programmatic access to SQL
  * impedance mismatch between SQL and languages: set-oriented vs record-oriented
  * terminal, GUI, embedded sql, sqlJ, odbc, jdbc, jrt
  * JDBC (java.sql, javax.sql)
    * Class.forName(“org.postgresql.Driver”);
    * c = DriverManager.getConnection("jdbc:postgresql://localhost/dbname", "login", "pwd");
    * Statement s = c.createStatement();
    * ResultSet rs = s.executeQuery("");
    * while(rs.next()) { String s = rs.getString(""); }
    * rs.close(); s.close(); c.close();
    * RS uses cursor method to iterate results.
    * everything can throw SqlException, handle it!
    * 2 level mapping: SQL - JDBC - JAVA types
    * conn pooling
    * release resources, try-with-resources java8
  
