# Terraform ECR Module

Terraform module that provides an Elastic Container Registry Repository, with a default lifecycle policy which expires all untag images.

## Usage

```hcl
module "ecr" {
  source              = "bryan-rhm/ecr/aws"
  version             = "1.0.0"
  name                = "my_repo"
  allowed_account_ids = ["123456655" , "23452345543"]
}

output "ecr_url" {
    value = module.ecr.output.repository_url
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=3.6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=3.6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_account_ids"></a> [allowed\_account\_ids](#input\_allowed\_account\_ids) | Allowed account ids to push into this repository | `list(string)` | `[]` | no |
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | Use "IMMUTABLE" to prevent image tags from being overwritten by subsequent image pushes using the same tag. Use "MUTABLE" to allow image tags to be overwritten. | `string` | `"MUTABLE"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | ARN of the KMS key to be used for encryption. | `string` | `null` | no |
| <a name="input_lifecycle_policy"></a> [lifecycle\_policy](#input\_lifecycle\_policy) | Lifecycle policy for this repository | `any` | `null` | no |
| <a name="input_max_image_count"></a> [max\_image\_count](#input\_max\_image\_count) | Set a limit on the number of images that exist in the repository. | `number` | `30` | no |
| <a name="input_name"></a> [name](#input\_name) | repo name | `string` | n/a | yes |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Wheter scan on push should be enabled | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to the resource. | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_output"></a> [output](#output\_output) | ECR Repository attributes |
