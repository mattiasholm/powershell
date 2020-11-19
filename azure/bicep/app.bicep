var prefix = resourceGroup().name
var location = resourceGroup().location


param planSku string
param planCapacity int

var planName = '${prefix}-AppPlan01'
var planKind = 'app'

resource plan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: planName
  location: location
  kind: planKind
  sku: {
    name: planSku
    capacity: planCapacity
  }
}



var appName = '${prefix}-App01'
var appHttpsOnly = true

resource app 'Microsoft.Web/sites@2020-06-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: plan.id
    httpsOnly: appHttpsOnly
  }
}

output appUrl string = app.properties.defaultHostName