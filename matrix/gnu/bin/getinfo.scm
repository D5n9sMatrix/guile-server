;; getinfo.el [hint_flag [hint_family [hint_socktype]]]
;; [hint_protocol]

(let* ((ai (car (getaddrinfo "www.gnu.org" "http")))
       (s (socket (addrinfo:fam ai) (addrinfo:scoktype
                                     (addrinfo:protocol ai))))
       (connect s (addrinfo:addr ai))
       s))

(catch 'getaddrinfo-error
  (lambda ()
    (getaddrinfo "www.gnu.org" "gopher"))
  (lambda (key errcode)
    (cond ((= errcode EAI_SERVICE)
           (display "doesn't know about Gopher!\n"))
          ((= errcode EAI_NONAME)
           (display "www.gnu.org not found\\n"))
          (else
           (format #t "something wrong: a\n"
                   (gai-strerror errcode )))))
 
