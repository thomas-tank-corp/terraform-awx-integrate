resource "awx_organization" "default" {
  name            = var.awx_org
}

resource "awx_project" "default" {
  name                 = var.awx_project
  scm_type             = "git"
  scm_url              = var.playbook_repo_url
  scm_update_on_launch = true
  organisation_id      = awx_organization.default.id
}

resource "awx_inventory" "default" {
  name            = var.awx_inventory
  organisation_id = awx_organization.default.id
}

resource "awx_credential_machine" "default" {
  name = var.machine_credential_name
  organisation_id = awx_organization.default.id
  become_method = "sudo"
  become_username = var.ssh_username
  ssh_key_data = var.ssh_private_key
}

resource "awx_job_template_credential" "default" {
  job_template_id = awx_job_template.default.id
  credential_id   = awx_credential_machine.default.id
}

resource "awx_job_template" "default" {
  name           = var.job_template_name
  job_type       = "run"
  inventory_id   = awx_inventory.default.id
  project_id     = awx_project.default.id
  playbook       = var.job_template_playbook
  become_enabled = true
depends_on = [awx_project.default]
}

resource "awx_host" "default" {
  name         = var.ansible_host
  description  = "custom"
  inventory_id = awx_inventory.default.id
  enabled   = true
  variables = <<YAML
---
ansible_host: ${var.ansible_host}
YAML
}


