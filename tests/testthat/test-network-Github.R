test_that("Non Nested", {
  mydata <- fromJSON("https://api.github.com/users/hadley/orgs")
  expect_s3_class(mydata, "data.frame")
})

test_that("Nested 1 Level", {
  mydata <- fromJSON("https://api.github.com/users/hadley/repos")
  expect_s3_class(mydata, "data.frame")
  expect_s3_class(mydata$owner, "data.frame")
  expect_equal(nrow(mydata), nrow(mydata$owner))
})


test_that("Nested 1 Level", {
  mydata <- fromJSON("https://api.github.com/repos/hadley/ggplot2/issues")
  expect_s3_class(mydata, "data.frame")
  expect_s3_class(mydata$user, "data.frame")
  expect_s3_class(mydata$pull_request, "data.frame")
  expect_equal(nrow(mydata), nrow(mydata$pull_request))
})

test_that("Nested 1 Level within list", {
  mydata <- fromJSON("https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc")
  expect_type(mydata, "list")
  expect_s3_class(mydata$items, "data.frame")
  expect_s3_class(mydata$items$owner, "data.frame")
  expect_equal(nrow(mydata$items), nrow(mydata$items$owner))
})

test_that("Nested 2 Level", {
  mydata <- fromJSON("https://api.github.com/repos/hadley/ggplot2/commits")
  expect_s3_class(mydata, "data.frame")
  expect_s3_class(mydata$commit, "data.frame")
  expect_s3_class(mydata$commit$author, "data.frame")
  expect_type(mydata$commit$author$name, "character")
  expect_equal(nrow(mydata), nrow(mydata$commit))
  expect_equal(nrow(mydata), nrow(mydata$commit$author))
})

test_that("Nested inconsistent (payload), one-to-many", {
  mydata <- fromJSON("https://api.github.com/users/hadley/events")
  expect_s3_class(mydata, "data.frame")
  expect_s3_class(mydata$actor, "data.frame")
  expect_s3_class(mydata$repo, "data.frame")
  expect_type(mydata$type, "character")
  expect_s3_class(mydata$payload, "data.frame")

  #this is dynamic, depends on data
  if (any(mydata$type == "PushEvent")) {
    expect_true(all(vapply(
      mydata$payload$commits,
      function(x) {
        is.null(x) || is.data.frame(x)
      },
      logical(1)
    )))
  }
})

test_that("Nested inconsistent (payload), one-to-many", {
  mydata <- fromJSON("https://api.github.com/repos/hadley/ggplot2/events")
  if (any("ForkEvent" %in% mydata$type)) {
    expect_s3_class(mydata$payload$forkee$owner, "data.frame")
  }

  if (any(mydata$type %in% c("IssuesEvent", "IssueCommentEvent"))) {
    expect_s3_class(mydata$payload$issue, "data.frame")
    expect_s3_class(mydata$payload$issue$user, "data.frame")
  }
})
