FROM honeygain/honeygain

ENV email ""
ENV password ""
ENV device "Test"

ENTRYPOINT ./honeygain "-tou-accept" "-email=$email" "-pass=$password" "-device=$device"
