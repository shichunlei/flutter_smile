part of charts;

class _ChartSeries {
  _ChartSeries();

  SfCartesianChart chart;

  /// Contains the visible series for chart
  List<ChartSeries<dynamic, dynamic>> visibleSeries;
  List<_ClusterStackedItemInfo> clusterStackedItemInfo;

  void processData() {
    final List<ChartSeries<dynamic, dynamic>> seriesList = visibleSeries;
    _findAreaType();
    _populateDataPoints(seriesList);
    for (ChartSeries<dynamic, dynamic> series in seriesList) {
      _setSeriesType(series);

      /// Calculate empty point
      _calculateEmptyPoints(series);
    }
    chart._chartAxis?._calculateVisibleAxes();
    _findSeriesMinMax(seriesList);
  }

  /// Find the data points for each series
  void _populateDataPoints(List<CartesianSeries<dynamic, dynamic>> seriesList) {
    for (CartesianSeries<dynamic, dynamic> series in seriesList) {
      final dynamic xValue = series.xValueMapper;
      final dynamic yValue = series.yValueMapper;
      final dynamic sortField = series.sortFieldValueMapper;
      final dynamic _pointColor = series.pointColorMapper;
      final dynamic _bubbleSize = series.sizeValueMapper;
      final dynamic _pointText = series.dataLabelMapper;
      final dynamic _highValue = series.highValueMapper;
      final dynamic _lowValue = series.lowValueMapper;

      series._dataPoints = <_CartesianChartPoint<dynamic>>[];
      if (series.dataSource != null) {
        for (int pointIndex = 0;
            pointIndex < series.dataSource.length;
            pointIndex++) {
          final dynamic xVal = xValue(pointIndex);
          final dynamic yVal = yValue(pointIndex);
          if (xVal != null) {
            dynamic sortVal,
                pointColor,
                bubbleSize,
                pointText,
                highValue,
                lowValue;
            if (series.sortFieldValueMapper != null) {
              sortVal = sortField(pointIndex);
            }
            series._dataPoints.add(_CartesianChartPoint<dynamic>(xVal, yVal));
            if (series.sizeValueMapper != null) {
              bubbleSize = _bubbleSize(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].bubbleSize =
                  (bubbleSize != null) ? bubbleSize.toDouble() : bubbleSize;
            }
            if (series.pointColorMapper != null) {
              pointColor = _pointColor(pointIndex);
              series._dataPoints[series._dataPoints.length - 1]
                  .pointColorMapper = pointColor;
            }
            if (series.dataLabelMapper != null) {
              pointText = _pointText(pointIndex);
              series._dataPoints[series._dataPoints.length - 1]
                  .dataLabelMapper = pointText;
            }

            /// for range series
            if (series.highValueMapper != null) {
              highValue = _highValue(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].high =
                  highValue;
            }
            if (series.lowValueMapper != null) {
              lowValue = _lowValue(pointIndex);
              series._dataPoints[series._dataPoints.length - 1].low = lowValue;
            }

            if (series.sortingOrder != SortingOrder.none && sortVal != null)
              series._dataPoints[series._dataPoints.length - 1].sortValue =
                  sortVal;
          }
        }
        if (series.sortingOrder != SortingOrder.none &&
            series.sortFieldValueMapper != null) {
          _sortDataSource(series);
        }
      }
    }
  }

  /// Sort the datasource
  void _sortDataSource(CartesianSeries<dynamic, dynamic> series) {
    series._dataPoints.sort(
        // ignore: missing_return
        (_CartesianChartPoint<dynamic> firstPoint,
            _CartesianChartPoint<dynamic> secondPoint) {
      if (series.sortingOrder == SortingOrder.ascending) {
        return (firstPoint.sortValue == null)
            ? -1
            : (secondPoint.sortValue == null
                ? 1
                : (firstPoint.sortValue is String
                    ? firstPoint.sortValue
                        .toLowerCase()
                        .compareTo(secondPoint.sortValue.toLowerCase())
                    : firstPoint.sortValue.compareTo(secondPoint.sortValue)));
      } else if (series.sortingOrder == SortingOrder.descending) {
        return (firstPoint.sortValue == null)
            ? 1
            : (secondPoint.sortValue == null
                ? -1
                : (firstPoint.sortValue is String
                    ? secondPoint.sortValue
                        .toLowerCase()
                        .compareTo(firstPoint.sortValue.toLowerCase())
                    : secondPoint.sortValue.compareTo(firstPoint.sortValue)));
      }
    });
  }

  void _findSeriesMinMax(List<CartesianSeries<dynamic, dynamic>> seriesList) {
    for (CartesianSeries<dynamic, dynamic> series in seriesList) {
      final dynamic axis = series._xAxis;
      if (axis is NumericAxis) {
        axis._findAxisMinMax(series);
      } else if (axis is CategoryAxis) {
        axis._findAxisMinMax(series);
      } else if (axis is DateTimeAxis) {
        axis._findAxisMinMax(series);
      } else {
        axis._findAxisMinMax(series);
      }
    }
  }

  /// Calculate area type
  void _findAreaType() {
    if (visibleSeries.isNotEmpty) {
      final bool isBarSeries =
          visibleSeries[0].runtimeType.toString().contains('Bar');
      chart._requireInvertedAxis =
          (chart.isTransposed != true && isBarSeries) ||
              ((chart.isTransposed == true) && (isBarSeries == false));
    } else {
      chart._requireInvertedAxis = chart.isTransposed;
    }
  }

  void _setSeriesType(CartesianSeries<dynamic, dynamic> series) {
    if (series is AreaSeries)
      series._seriesType = 'area';
    else if (series is BarSeries)
      series._seriesType = 'bar';
    else if (series is ColumnSeries)
      series._seriesType = 'column';
    else if (series is FastLineSeries)
      series._seriesType = 'fastline';
    else if (series is LineSeries)
      series._seriesType = 'line';
    else if (series is ScatterSeries)
      series._seriesType = 'scatter';
    else if (series is SplineSeries) series._seriesType = 'spline';
  }
}
