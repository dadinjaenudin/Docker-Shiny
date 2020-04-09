FROM rocker/shiny:latest

# docker build -t shiny:latest .

MAINTAINER Dadin jaenudin "jaenudin@gmail.com"

#install ssl
RUN sudo apt-get update; exit 0
RUN sudo apt-get install -y libssl-dev libxml2-dev

RUN mkdir -p /srv/shiny-server/ && \
    chown -R shiny:shiny /srv/shiny-server/

RUN mkdir -p /home/shiny/ && \
    chown -R shiny:shiny /home/shiny/

RUN touch /home/shiny/.Renviron
RUN chown shiny.shiny /home/shiny/.Renviron

RUN R -e "install.packages(c('tidyverse','libxml-2.0','shinydashboardPlus','flexdashboard', 'dplyr','lubridate','dygraphs','xts','DT','echarts4r','shinyWidgets','shinydashboard','shiny','miniUI','jpeg','text2vec','keras','shinythemes','leaflet','plotly','scales','shinycssloaders','shinyjs','xlsx'))"

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN chmod a+x /usr/bin/shiny-server.sh
 
#CMD ["/usr/bin/shiny-server.sh"]
CMD ["R", "-e", "shiny::runApp('/srv/shiny-server',port=3838, host='0.0.0.0')"]
