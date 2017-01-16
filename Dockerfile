FROM rocker/tidyverse

# ------------------------------
# Install rstanarm and friends
# ------------------------------
# Docker Hub (and Docker in general) chokes on memory issues when compiling
# with gcc, so copy custom CXX settings to /root/.R/Makevars and use ccache and
# clang++ instead

# Make ~/.R
RUN mkdir -p $HOME/.R

# $HOME doesn't exist in the COPY shell, so be explicit
COPY R/Makevars /root/.R/Makevars

# Install ed, wince nloptr needs it to compile.
# Install all the dependencies needed by rstanarm and friends
RUN apt-get -y --no-install-recommends install \
    ed \
    clang  \
    ccache \
    && install2.r --error \
        miniUI PKI RCurl RJSONIO packrat minqa nloptr matrixStats inline \
        colourpicker DT dygraphs gtools rsconnect shinyjs shinythemes threejs \
        xts bayesplot lme4 loo rstantools StanHeaders RcppEigen \
        rstan shinystan rstanarm 


# ---------------
# Install fonts
# ---------------
# Cairo and other helpful libraries
RUN apt-get -y --no-install-recommends install \
    libxt-dev \
    && install2.r --error \
        Cairo pander

# Place to put fonts
RUN mkdir -p $HOME/fonts

# Source Sans Pro
COPY scripts/install_source_sans.sh /root/fonts/install_source_sans.sh
RUN . $HOME/fonts/install_source_sans.sh

# Open Sans
RUN mkdir -p /tmp/OpenSans
COPY scripts/install_open_sans.sh /root/fonts/install_open_sans.sh
COPY fonts/Open_Sans.zip /tmp/OpenSans/Open_Sans.zip
RUN . $HOME/fonts/install_open_sans.sh
