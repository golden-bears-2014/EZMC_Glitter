$(document).ready(function() {
  // user_survey = new Survey();
  var counter = 1
  $('#add-question').on("click",function(e){

    e.preventDefault()
    var template = $('#question_template')
    template.find('.question').attr('name', counter + 'question' )
    template.find('.optiona').attr('name', counter + 'optiona' )
    template.find('.optionb').attr('name', counter + 'optionb' )
    template.find('.optionc').attr('name', counter + 'optionc' )
    var questionTemplate = $.trim(template.html())
    $('.survey-builder').append(questionTemplate)
    counter += 1
  });
}); //end of document ready

var formatGraph = function (question_id, question, choices, answerCount) {
        $('#graph'+question_id).highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: question
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: choices
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total Tally'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0"></td>' +
                    '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [
                    {
                showInLegend: false,
                data: answerCount
            }
            ]
        });

    };