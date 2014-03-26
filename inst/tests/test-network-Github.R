context("Github API")

test_that("Non Nested", {  
  mydata <- fromJSON("https://api.github.com/users/hadley/orgs");
  expect_that(mydata, is_a("data.frame"));  
});

test_that("Nested 1 Level", {  
  mydata <- fromJSON("https://api.github.com/users/hadley/repos");
  expect_that(mydata, is_a("data.frame"));
  expect_that(mydata$owner, is_a("data.frame"));
  expect_that(nrow(mydata), equals(nrow(mydata$owner)));
});


test_that("Nested 1 Level", {  
  mydata <- fromJSON("https://api.github.com/repos/hadley/ggplot2/issues");
  expect_that(mydata, is_a("data.frame"));
  expect_that(mydata$user, is_a("data.frame"));
  expect_that(mydata$pull_request, is_a("data.frame"));
  expect_that(nrow(mydata), equals(nrow(mydata$pull_request)));
});

test_that("Nested 1 Level within list", {  
  mydata <- fromJSON("https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc");
  expect_that(mydata, is_a("list"));
  expect_that(mydata$items, is_a("data.frame"));
  expect_that(mydata$items$owner, is_a("data.frame"));  
  expect_that(nrow(mydata$items), equals(nrow(mydata$items$owner)));
});

test_that("Nested 2 Level", {  
  mydata <- fromJSON("https://api.github.com/repos/hadley/ggplot2/commits");
  expect_that(mydata, is_a("data.frame"));
  expect_that(mydata$commit, is_a("data.frame"));
  expect_that(mydata$commit$author, is_a("data.frame"));
  expect_that(mydata$commit$author$name, is_a("character"));
  expect_that(nrow(mydata), equals(nrow(mydata$commit)));
  expect_that(nrow(mydata), equals(nrow(mydata$commit$author)));
});

test_that("Nested inconsistent (payload), one-to-many", {  
  mydata <- fromJSON("https://api.github.com/users/hadley/events");
  expect_that(mydata, is_a("data.frame"));
  expect_that(mydata$actor, is_a("data.frame"));
  expect_that(mydata$repo, is_a("data.frame"));
  expect_that(mydata$type, is_a("character"));
  expect_that(mydata$payload, is_a("data.frame"));
  
  #this is dynamic, depends on data
  if(any(mydata$type == "PushEvent")){
    expect_that(all(vapply(mydata$payload$commits, function(x){is.null(x) || is.data.frame(x)}, logical(1))), is_true());
  }
});

test_that("Nested inconsistent (payload), one-to-many", {  
  mydata <- fromJSON("https://api.github.com/repos/hadley/ggplot2/events");
  if(any("ForkEvent" %in% mydata$type)){
    expect_that(mydata$payload$forkee$owner, is_a("data.frame"))
  }
  
  if(any(mydata$type %in% c("IssuesEvent", "IssueCommentEvent"))){
    expect_that(mydata$payload$issue, is_a("data.frame"));
    expect_that(mydata$payload$issue$user, is_a("data.frame"));
  }
});
