#************************************************************************** */
#                                                                           */
#                                                       :::      ::::::::   */
#  Dockerfile.yml                                     :+:      :+:    :+:   */
#                                                   +:+ +:+         +:+     */
#  By:castorga <castorga@student.42barcelona.com> +#+  +:+       +#+        */
#                                               +#+#+#+#+#+   +#+           */
#  Created: 2025/03/23 17:30:00 by castorga          #+#    #+#             */
#  Updated: 2025/03/23 17:30:00 by castorga         ###   ########.fr       */
#                                                                           */
#************************************************************************** */

FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx

COPY ./index.html /var/www/html/index.html

EXPOSE 80

# Iniciar nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
