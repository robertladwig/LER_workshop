FROM rocker/verse:4.0.0-ubuntu18.04

MAINTAINER  "Tadgh Moore" tadhgm@vt.edu 

RUN apt-get update -qq && apt-get -y --no-install-recommends install \
	gfortran-8 \
	gfortran \
	libgd-dev \
	git \
	build-essential \
	libnetcdf-dev \
	libnetcdff-dev \
	tzdata \
	ca-certificates \
	&& update-ca-certificates

RUN 	Rscript -e 'install.packages("ncdf4")' \
	&& Rscript -e 'install.packages("devtools")' \
	&& Rscript -e 'devtools::install_github("robertladwig/GLM3r",ref="v3.1.1")' \ 
	&& Rscript -e 'devtools::install_github("USGS-R/glmtools", ref = "ggplot_overhaul")' \
	&& Rscript -e 'devtools::install_github("GLEON/rLakeAnalyzer")' \
	&& Rscript -e 'devtools::install_github("aemon-j/FLakeR", ref = "inflow")' \
	&& Rscript -e 'devtools::install_github("aemon-j/GOTMr")' \
	&& Rscript -e 'devtools::install_github("aemon-j/gotmtools", ref = "yaml")' \
	&& Rscript -e 'devtools::install_github("aemon-j/SimstratR")' \
	&& Rscript -e 'devtools::install_github("aemon-j/MyLakeR")' \
	&& Rscript -e 'install.packages("configr")' \
	&& Rscript -e 'install.packages("import")' \
	&& Rscript -e 'install.packages("FME")' \
	&& Rscript -e 'install.packages("lubridate")' \
	&& Rscript -e 'install.packages("plyr")' \
	&& Rscript -e 'install.packages("reshape2")' \
	&& Rscript -e 'install.packages("zoo")' \
	&& Rscript -e 'install.packages("ggplot2")' \
	&& Rscript -e 'install.packages("dplyr")' \
	&& Rscript -e 'install.packages("RColorBrewer")' \
	&& Rscript -e 'install.packages("tools")' \
	&& Rscript -e 'install.packages("akima")' \
	&& Rscript -e 'install.packages("lazyeval")' \
	&& Rscript -e 'install.packages("hydroGOF")' \
	&& Rscript -e 'install.packages("RSQLite")' \
	&& Rscript -e 'install.packages("XML")' \
	&& Rscript -e 'install.packages("MBA")' \
	&& Rscript -e 'install.packages("colorRamps")' \
	&& Rscript -e 'install.packages("gridExtra")' \
	&& Rscript -e 'install.packages("readr")' \
	&& Rscript -e 'install.packages("ggpubr")' \
	&& Rscript -e 'devtools::install_github("tadhg-moore/LakeEnsemblR", ref = "flare")'

RUN 	echo "rstudio  ALL=(ALL) NOPASSWD:ALL">>/etc/sudoers

RUN	mkdir /home/rstudio/workshop
WORKDIR /home/rstudio/workshop
COPY . /home/rstudio/workshop/
RUN chmod -R 777 .

COPY rserver.conf /etc/rstudio/rserver.conf
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install py-cdrive-api
