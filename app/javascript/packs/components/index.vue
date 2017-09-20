<template>
  <div>
    <!-- 新規作成部分 -->
    <div class="row margin-default">
      <div class="col s10 m11">
        <input v-model="newTask" id="new-task-form" class="form-control padding-default" placeholder="Add your task!!">
      </div>
      <div class="col s2 m1">
        <button class="btn-floating waves-effect waves-light red" v-on:click="createTask">
          <i class="material-icons">add</i>
        </button>
      </div>
    </div>
    <!-- リスト表示部分 -->
    <div>
      <ul class="collection">
        <li v-bind:id="'row_task_' + task.id" class="collection-item" v-for="task in tasks" v-if="!task.is_done">
          <input type="checkbox" v-bind:id="'task_' + task.id" v-on:change="doneTask(task.id)" />
          <label v-bind:for="'task_' + task.id" class="word-color-black">{{ task.name }}</label>
        </li>
      </ul>
    </div>
    <!-- 完了済みタスク表示ボタン -->
    <button class="btn btn-custom" v-on:click="displayFinishedTasks">Display finished tasks</button>
    <!-- 完了済みタスク一覧 -->
    <div id="finished-tasks" class="display_none">
      <ul class="collection">
        <li v-bind:id="'row_task_' + task.id" class="collection-item" v-for="task in tasks" v-if="task.is_done">
          <input type="checkbox" v-bind:id="'task_' + task.id" checked="checked" />
          <label v-bind:for="'task_' + task.id"  class="line-through">{{ task.name }}</label>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function () {
      return {
        tasks: [],
        newTask: ''
      }
    },
    mounted: function () {
      this.fetchTasks();
    },
    methods: {
      fetchTasks: function () {
        axios.get('/api/tasks').then((response) => {
          for(var i = 0; i < response.data.tasks.length; i++) {
            this.tasks.push(response.data.tasks[i]);
          }
        }, (error) => {
          console.log(error);
        });
      },
      createTask: function () {
        if (!this.newTask) return;
        axios.post('/api/tasks', { task: { name: this.newTask } }).then((response) => {
          this.tasks.unshift(response.data.task);
          this.newTask = '';
        }, (error) => {
          console.log(error);
        });
      },
      doneTask: function (task_id) {
        axios.put('/api/tasks/' + task_id, { task: { is_done: 1 } }).then((response) => {
          this.moveFinishedTask(task_id);
        }, (error) => {
          console.log(error);
        });
      },
      displayFinishedTasks: function() {
        document.querySelector('#finished-tasks').classList.toggle('display_none');
      },
      moveFinishedTask: function(task_id) {
        var el = document.querySelector('#row_task_' + task_id);
        // DOMをクローンしておく
        var el_clone = el.cloneNode(true);
        // 未完了の方を先に非表示にする
        el.classList.add('display_none');
        // もろもろスタイルなどをたして完了済みに追加
        el_clone.getElementsByTagName('input')[0].checked = 'checked';
        el_clone.getElementsByTagName('label')[0].classList.add('line-through');
        el_clone.getElementsByTagName('label')[0].classList.remove('word-color-black');
        var li = document.querySelector('#finished-tasks > ul > li:first-child');
        document.querySelector('#finished-tasks > ul').insertBefore(el_clone, li);
      }
    }
  }
</script>

<style scoped>
  [v-cloak] {
    display: none;
  }
  .margin-default {
    margin-top: 30px;
  }
  .padding-default {
    padding-left: 20px;
  }
  .word-color-black {
    color: #000000;
  }
  .collection-item:hover {
    background-color: #ddd;
  }
  .display_none {
    display:none;
  }
  .line-through {
    text-decoration: line-through;
  }
  .btn-custom {
    text-transform: none;
    padding: 0 10px;
    font-size: 0.8rem;
    background-color: white;
    color: black;
    border-color: black;
  }
</style>