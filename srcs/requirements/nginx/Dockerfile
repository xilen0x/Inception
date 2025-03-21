#************************************************************************** */
#                                                                           */
#                                                       :::      ::::::::   */
#  Dockerfile.yml                                     :+:      :+:    :+:   */
#                                                   +:+ +:+         +:+     */
#  By:castorga <castorga@student.42barcelona.com> +#+  +:+       +#+        */
#                                               +#+#+#+#+#+   +#+           */
#  Created: 2025/03/10 17:30:00 by castorga          #+#    #+#             */
#  Updated: 2025/03/21 17:30:00 by castorga         ###   ########.fr       */
#                                                                           */
#************************************************************************** */

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/apt/lists/*

EXPOSE 443

COPY --chmod=755 ./conf/default.conf /etc/nginx/sites-available/.default 
COPY --chmod=755 ./tools/init.sh /usr/local/bin/ssl_init.sh

ENTRYPOINT ["/usr/local/bin/ssl_init.sh"]

CMD ["nginx", "-g", "daemon off;"]