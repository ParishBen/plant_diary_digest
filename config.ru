require './config/environment'

use Rack::MethodOverride
use LogController
use UserController
use TipController
use PlantController
run ApplicationController