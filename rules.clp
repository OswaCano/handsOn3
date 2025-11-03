
;;Define a rule for finding those customers who have not bought nothing at all... so far

(defrule cust-not-buying
     (customer (customer-id ?id) (name ?name))
     (not (order (order-number ?order) (customer-id ?id)))
   =>
   (printout t ?name " no ha comprado... nada!" crlf))


;;Define a rule for finding which products have been bought

(defrule prods-bought
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?pn " was bought " crlf))


;;Define a rule for finding which products have been bought AND their quantity

(defrule prods-qty-bgt
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part) (quantity ?q))
   (product (part-number ?part) (name ?p) )
   =>
   (printout t ?q " " ?p " was/were bought " crlf))

;;Define a rule for finding customers and their shopping info

(defrule customer-shopping
   (customer (customer-id ?id) (name ?cn))
   (order (order-number ?order) (customer-id ?id))
   (line-item (order-number ?order) (part-number ?part))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?cn " bought  " ?pn crlf))

;;Define a rule for finding those customers who bought more than 5 products

(defrule cust-5-prods
   (customer (customer-id ?id) (name ?cn))
   (order (order-number ?order) (customer-id ?id))
   (line-item (order-number ?order) (part-number ?part) (quantity ?qty&:(> ?qty 5)))
   (product (part-number ?part) (name ?pn))
   =>
   (printout t ?cn " bought more than 5 products (" ?pn ")" crlf))

;; Define a rule for texting custormers who have not bought ...

(defrule text-cust (customer (customer-id ?cid) (name ?name) (phone ?phone))
                   (not (order (order-number ?order) (customer-id ?cid)))
=>
(assert (text-customer ?name ?phone "tienes 25% desc prox compra"))
(printout t ?name " 3313073905 tienes 25% desc prox compra" ))


;; Define a rule for calling  custormers who have not bought ...
(defrule call-cust (customer (customer-id ?cid) (name ?name) (phone ?phone))
                   (not (order (order-number ?order) (customer-id ?cid)))
=>
(assert (call-customer ?name ?phone "tienes 25% desc prox compra"))
(printout t ?name " 3313073905 tienes 25% desc prox compra" ))


;; Edicion de codigo por Cano Lopez Brayan Oswaldo
;; Recomendar productos similares

(defrule recommend-similar-category
   (customer (customer-id ?cid) (name ?name))
   (order (order-number ?order) (customer-id ?cid))
   (line-item (order-number ?order) (part-number ?p1))
   (product (part-number ?p1) (category ?cat))
   (product (part-number ?p2) (category ?cat))
   (test (neq ?p1 ?p2)) ; evita recomendar el mismo producto
   =>
   (printout t "Recomendación para " ?name ": prueba otros productos de la categoría '" ?cat "'" crlf))

;; Recomendar algo a quienes aun no han comprado

(defrule recommend-for-inactive-customer
   (customer (customer-id ?cid) (name ?name))
   (not (order (customer-id ?cid)))
   =>
   (assert (recomendacion (id ?cid) (mensaje "¡Aprovecha un 25% de descuento en tu primera compra! ")))
   (printout t ?name " → ¡Aprovecha un 25% de descuento en tu primera compra! " crlf))

;; Recomendar productos populares

(defrule recommend-popular-product
   (line-item (part-number ?p) (quantity ?q&:(> ?q 5)))
   (product (part-number ?p) (name ?name))
   (customer (customer-id ?cid) (name ?cname))
   (not (line-item (customer-id ?cid) (part-number ?p))) ; el cliente no lo ha comprado
   =>
   (printout t "Recomendación para " ?cname ": el producto más popular es ' " ?name "' " crlf))

