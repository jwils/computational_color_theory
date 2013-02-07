var questions = [];
var question = 1;
var answer_json = [];
var response_json = {};
var quiz_id;

function startQuiz() {
    closeInstructions();
    var rulerWidth = $("#ruler-width").val();
    var rulerHeight = $("#ruler-height").val();

    $("#survey_ruler_width").val(JSON.stringify($("#ruler-width").val()));
    $("#survey_ruler_height").val(JSON.stringify($("#ruler_height").val()));
    recordMeasurement(rulerWidth, rulerHeight);
}

function recordMeasurement(width, height) {
    measurements = {width: width, height: height};
    response_json['measurements'] = measurements;
}

function closeInstructions() {
    $("div#qHolder").show()
    $("div#instructions").hide();
    questions = $('#qHolder').data('questions');

    nextQuestion(questions[question -1].img1,
    questions[question -1].img2);
    //quiz_id = data['quiz_id']
}

function imgClick() {
    if ($("img.answer1").attr("disabled")) {
        return;
    }
    if ($(this).attr("class") == "answer1") {
        image = "img1"
    } else {
        image = "img2"
    }
    answer_json.push({ question_id : questions[question -1].id,
        chosen_image : image});

    question = question + 1;
    if (question > questions.length) {
        response_json['answers'] = answer_json;
        response_json['quiz_id'] = quiz_id;
      //Submit results
      $("div#qHolder").hide()
      $("div#completion").show();
      $("button").hide();
      $("#survey_responses").val(JSON.stringify(answer_json));

/*      $.ajax({
      type: 'POST',
      url: "/answers/",
      data: JSON.stringify(response_json),
      dataType: 'json',
      success: function(data) {
        $('#response_code').html(data['resp_code']);
      },
        failure: function(data) {alert('error');}
      });*/
        return;
      } else {
        nextQuestion(questions[question -1].img1,
        questions[question -1].img2);
      }
}

  function prepareForNextQuestion() {
    $("div#mouseDiv").show();
  }

  function onMousePlace() {
    $("div#mouseDiv").hide();
    $("div#qHolder").fadeIn("slow", function() {
    $("img.answer1").attr("disabled", false);
    $("img.answer2").attr("disabled", false);
  });
  }

  function nextQuestion(image1, image2) {
    $("img.answer1").attr("disabled", true);
    $("img.answer2").attr("disabled", true);

    $("div#qHolder").fadeOut(1000, function(){
        $("img.answer1").attr("src",  image1.image_url);
        $("img.answer2").attr("src",  image2.image_url);
        prepareForNextQuestion();
    });
  }
