# deploy.tftest.hcl

run "deploy" {
  command = apply

  module {
    source = "./."
  }

  outputs = {
    api_endpoint = output.api_endpoint
  }
}

run "validate" {
  command = apply

  module {
    source = "../../modules/test-endpoint"
  }

  variables {
    endpoint = run.deploy.outputs.api_endpoint
  }

  assert {
    condition = data.http.test_endpoint.status_code == 200
    error_message = "Unexpected status code:\n${data.http.test_endpoint.status_code}"
  }

  assert {
    condition = data.http.test_endpoint.response_body == "Hello, World!"
    error_message = "Unexpected response body:\n${data.http.test_endpoint.response_body}"
  }
}
