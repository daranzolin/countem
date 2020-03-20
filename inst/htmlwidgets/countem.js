HTMLWidgets.widget({

  name: 'countem',

  type: 'output',

  factory: function(el, width, height) {

    return {

      renderValue: function(opts) {

        let data = HTMLWidgets.dataframeToD3(opts.data);
        //console.log(data);

        data.forEach(d => {
          d.n = +d.n;
        });

        const svg = d3.select(el)
                    .append("svg")
                    .style("width", "100%")
                    .style("height", "100%");

        let margin = {left:20, right:50, top:50, bottom:50};
        let vars = opts.vars;
        let t = d3.transition().duration(opts.bar_interval);
        let cycleCounter = 0;
        let currVar = vars[0];
        let currData = data.filter(d => d.var === currVar);

        let xAxisGroup = svg.append("g")
              .attr("transform", `translate(0, ${height - margin.bottom})`);

        let yAxisGroup = svg.append("g")
              .attr("transform", `translate(${margin.right}, 0)`);

        let x = d3.scaleBand()
              .range([margin.right, width])
              .padding(0.2);
        let y = d3.scaleLinear()
              .range([height - margin.bottom, margin.top]);

        let xLab = svg.append("text")
              .attr("y", height - (margin.bottom/2) + 12)
              .attr("x", width / 2)
              .attr("font-family", "sans-serif")
              .attr("font-size", "20px")
              .attr("text-anchor", "middle");

        let yLab = svg.append("text")
              .attr("y", margin.top - 10)
              .attr("x", margin.left)
              .attr("font-family", "sans-serif")
              .attr("font-size", "12px")
              .attr("text-anchor", "middle")
              .text("Counts");

        update(currData, currVar);

        d3.interval(function(){
          cycleCounter = cycleCounter === vars.length - 1 ? 0 : cycleCounter + 1;
          currVar = vars[cycleCounter];
          currData = data.filter(d => d.var === currVar);
          if (opts.sort_bars) {
            currData = currData.sort((a, b) => a.n - b.n);
          }
          update(currData, currVar);
        }, opts.chart_interval);

        function update(data, currVar) {

            x.domain(data.map(d => d.x));
            y.domain([0, d3.max(data, d => d.n)]);
            xLab.text(currVar);

            let xAxisCall = d3.axisBottom(x);
            xAxisGroup.transition(t).call(xAxisCall);

            let yAxisCall = d3.axisLeft(y);
            yAxisGroup.transition(t).call(yAxisCall);

            let rects = svg.selectAll("rect")
                .data(data, function(d) {
                  return d.x;
                });

            rects.exit()
                //.attr("fill", "firebrick")
            //.transition(t)
                //.attr("y", y(0))
                //.attr("height", d => height - margin.bottom - y(d.n))
                //.attr("opacity", 0)
                .remove();

            rects.enter()
                .append("rect")
                    .attr("fill", opts.fill)
                    .attr("y", y(0))
                    //.attr("height", y(0))
                    .attr("x", d => x(d.x))
                    .attr("width", x.bandwidth)
                    .merge(rects)
                    .transition().duration(opts.bar_interval)
                        .attr("x", d => x(d.x))
                        .attr("width", x.bandwidth())
                        .attr("y", d => y(d.n))
                        .attr("height", d => height - margin.bottom - y(d.n));

        }

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
