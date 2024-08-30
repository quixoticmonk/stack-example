resource "awscc_bedrock_guardrail" "example" {
  name                      = var.name
  blocked_input_messaging   = "Blocked input"
  blocked_outputs_messaging = "Blocked output"
  description               = "Example guardrail"

  content_policy_config = {
    filters_config = [
      {
        input_strength  = "MEDIUM"
        output_strength = "MEDIUM"
        type            = "HATE"
      },
      {
        input_strength  = "HIGH"
        output_strength = "HIGH"
        type            = "VIOLENCE"
      }
    ]
  }

  tags = var.tags

}

variable "name" {
  type = string
  description = "Name of the Guardrail"
}

variable "tags" {
  type = list(object({
    key = string
    value = string
  }))
  description = "tags"
}