terragrunt = {
    terraform {
        source = "/project/modules//redis"
    }

    include = {
        path = "${find_in_parent_folders()}"
    }
}
