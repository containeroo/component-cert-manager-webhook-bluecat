local kap = import 'lib/kapitan.libjsonnet';
local inv = kap.inventory();
local params = inv.parameters.cert_manager_webhook_bluecat;
local argocd = import 'lib/argocd.libjsonnet';

local app = argocd.App('cert-manager-webhook-bluecat', params.namespace);

local appPath =
  local project = std.get(std.get(app, 'spec', {}), 'project', 'syn');
  if project == 'syn' then 'apps' else 'apps-%s' % project;

{
  ['%s/cert-manager-webhook-bluecat' % appPath]: app,
}
