server {
    server_name prometheus.aleksandrfaer.ru;

    location / {
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/.htpasswd;
        proxy_pass http://localhost:9090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/prometheus.aleksandrfaer.ru/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/prometheus.aleksandrfaer.ru/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
    server_name grafana.aleksandrfaer.ru;

    location / {
        auth_basic "Restricted Access";
        auth_basic_user_file /etc/nginx/.htpasswd;
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    listen 443 ssl; # managed by Certbot
    ssl_certificate /etc/letsencrypt/live/prometheus.aleksandrfaer.ru/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/prometheus.aleksandrfaer.ru/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

}

server {
    if ($host = prometheus.aleksandrfaer.ru) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name prometheus.aleksandrfaer.ru;
    return 404; # managed by Certbot


}

server {
    if ($host = grafana.aleksandrfaer.ru) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name grafana.aleksandrfaer.ru;
    return 404; # managed by Certbot


}
