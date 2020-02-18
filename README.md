# README

This is a simple "starter" services pair, which consists of two containers - `express-api` and `postgres`.

To check how it works quickly, use `docker-compose up -d` command. It'll:

- build Docker image from the Dockerfile instructions
- up `postgres` service
- up `express-api` service, which depends on `postgres` running

What is good: We don't expose 5432 port for DB service, as we do for API. Befause why should we? - We gonna query API, but we aren't gonna do it with DB. API can reach DB via internal container overlay network, and that's correct.

To test that, execute `docker exec -it node-postgre-starter-express-api_1 sh` and/or `docker exec -it node-postgre-starter-postgres_1 sh` and run `ping postgres` or `ping express-api`, appropriately (hostnames here are ones assigned by Docker and equal the service names). You'll see they are reachable by 172.19.0.{2,3} without any additional things.

To test API, do just `curl localhost:3000` (assuming testing on localhost; testing after deployment is different and depends on the hosting). You'll see "Hello Fake product" message.

## Deploying (to Heroku)

(I'm not as much deep familiar with Heroku; anyway).

Basically, the way to deploy this project is described in `main.tf` (yes, Terraform is used). It's to provide the way, t must be precised - GitHub IDs, secrets, etc. For example, Vault from HashiCorp probably can be used to harden all that.

### Comment to deploy

Do

```bash
git tag v0.1.0
git push origin v0.1.0
```

```bash
terraform apply
```
