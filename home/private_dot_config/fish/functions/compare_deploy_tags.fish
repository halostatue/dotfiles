function compare_deploy_tags
    set -l new_env $argv[1]
    set -l old_env $argv[2]

    set -l new_tag (aws2 ssm get-parameter --name /$new_env/booking/the-source/docker-tag --with-decryption | jq -r .Parameter.Value)
    set -l old_tag (aws2 ssm get-parameter --name /$old_env/booking/the-source/docker-tag --with-decryption | jq -r .Parameter.Value)

    set -l new_hash (string replace 'git-' '' $new_tag)
    set -l old_hash (string replace 'git-' '' $old_tag)

    git log $old_hash..$new_hash --reverse --format=%B
end
