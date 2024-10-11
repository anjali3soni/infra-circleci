resource "aws_elasticache_subnet_group" "yc-redis" {
  name       = "yc-redis"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Environment = "${local.env.environment}-subnet"
  }
}

resource "aws_cloudwatch_log_group" "yc-redis-prod-logs" {

  tags = {
    Environment = "${local.env.environment}-prod-logs"
    Name        = "${local.env.environment}-prod-logs"
  }
}

resource "aws_cloudwatch_log_group" "yc-redis-engine-logs" {

  tags = {
    Environment = "${local.env.environment}-engine-logs"
    Name        = "${local.env.environment}-engine-logs"
  }
}


resource "aws_elasticache_replication_group" "yc-prod" {
  replication_group_id       = "yc-prod"
  description                = "yc-prod redis"
  node_type                  = "cache.t4g.medium"
  num_cache_clusters         = 1
  port                       = 6379
  subnet_group_name          = aws_elasticache_subnet_group.yc-redis.name
  security_group_ids         = [aws_security_group.instance.id]
  parameter_group_name       = "default.redis7"
  engine_version             = "7.1"
  automatic_failover_enabled = false
  multi_az_enabled           = false
#   num_node_groups            = 1
#   replicas_per_node_group    = 1
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.yc-redis-prod-logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.yc-redis-engine-logs.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
  maintenance_window         = "sat:00:00-sat:01:00"
  auto_minor_version_upgrade = true
  snapshot_retention_limit   = 0
  # at_rest_encryption_enabled = false
  # transit_encryption_enabled = false
  # auth_token                 = "abcdefgh1234567890"
  # auth_token_update_strategy = "ROTATE"
  tags = {
    Environment = "${local.env.environment}-yc-prod-redis"
    Name        = "${local.env.environment}-yc-prod-redis"
  }
}

output "primary_endpoint_address" {
  value = aws_elasticache_replication_group.yc-prod.primary_endpoint_address
}

output "reader_endpoint_address" {
  value = aws_elasticache_replication_group.yc-prod.reader_endpoint_address
}
