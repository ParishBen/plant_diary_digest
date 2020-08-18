require './config/environment'

use Rack::MethodOverride
use LogController
use TipController
use PlantController
run ApplicationController